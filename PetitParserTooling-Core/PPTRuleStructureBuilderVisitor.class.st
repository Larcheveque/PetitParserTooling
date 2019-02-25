Class {
	#name : #PPTRuleStructureBuilderVisitor,
	#superclass : #PPTGeneratorVisitor,
	#category : #'PetitParserTooling-Core'
}

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitAction: aPP2ActionNode [
	^ (self isASeparatedBy: aPP2ActionNode)
		ifTrue: [ PPTRuleSeparatedBy new
				rule: (aPP2ActionNode child children first accept: self);
				separator:
					(aPP2ActionNode child children second children first children first
						accept: self);
				yourself ]
		ifFalse: [ aPP2ActionNode child acceptVisitor: self ]
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitChoice: aPP2ChoiceNode [
	| key |
	key := aPP2ChoiceNode children
		collect: [ :aChild | aChild accept: self ]
		thenReject: #isNil.
	key
		ifEmpty: [ ^ nil ]
		ifNotEmpty: [ key size = aPP2ChoiceNode children size
				ifFalse: [ self
						signal:
							'The grammar should not have a choice between interesting stuff and rejected ones' ]
				ifTrue: [ ^ PPTRuleLeaf
						name:
							(self ruleReifications
								at: (key collect: #ruleName)
								ifAbsent: [ PPTChoiceReificationNotDefined new
										rulesCombination: key;
										contextNode: aPP2ChoiceNode;
										signal ]) ] ]
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitDelegate: aPP2DelegateNode [
	^ self generationStrategy
		if: aPP2DelegateNode name
		shouldBeIgnored: [ nil ]
		else: [ PPTRuleLeaf
				name:
					(self ruleRenaming
						at: aPP2DelegateNode name
						ifPresent: [ :renamingStack | renamingStack pop ]
						ifAbsent: [ aPP2DelegateNode name ]) ]
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitFlatten: aPP2FlattenNode [ 
	^ aPP2FlattenNode child accept: self
]

{ #category : #'entry-point' }
PPTRuleStructureBuilderVisitor >> visitGrammarRule: aGrammarRule [
	^ ([ aGrammarRule child accept: self ]
		on: PPTChoiceReificationNotDefined
		do: [ :exception | 
			exception contextNode = aGrammarRule child
				ifTrue:
					[ "In this case, the choice that is not reify is the direct child of the rule, so we will use directly the choice as a leaf" PPTRuleLeaf name: aGrammarRule name ]
				ifFalse: [ exception
						rule: aGrammarRule name;
						signal ] ])
		ifNil: [ PPTEmptyASTNode new
				rule: aGrammarRule;
				signal ]
		ifNotNil: [ :result | result ]
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitLiteralObject: aPP2LiteralObjectNode [ 
	^ nil
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitLiteralSequence: aPP2LiteralSequenceNode [ 
	^ nil
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitNot: aPP2NotNode [ 
	^ nil
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitOptional: aPP2OptionalNode [ 
	^ (aPP2OptionalNode child accept: self)
		ifNotNil: [ :result | 
			PPTRuleOptional new
				rule: result;
				yourself ]
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitPossesiveRepeating: aPP2PossesiveRepeatingNode [
	^ (aPP2PossesiveRepeatingNode child accept: self)
		ifNotNil: [ :childRule | 
			PPTRuleRepeating new
				rule: childRule;
				yourself ]
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitPredicateObject: aPP2PredicateObjectNode [ 
	^ nil
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitPredicateSequence: aPP2PredicateSequenceNode [ 
	^ nil
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitSequence: aPP2SequenceNode [ 
	^ PPTRulesWithPosition
		createFrom:
			((aPP2SequenceNode children
				collectWithIndex: [ :aChild :index | 
					(aChild accept: self)
						ifNotNil: [ :result | 
							PPTRuleNodePosition new
								position: index;
								node: result;
								yourself ] ]) reject: #isNil)
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitTrimming: aPP2TrimmingNode [ 
	^ aPP2TrimmingNode child accept: self
]
