"
I am the visitor that create all PPTRule tree from any parser
"
Class {
	#name : #PPTRuleStructureBuilderVisitor,
	#superclass : #PPTGeneratorVisitor,
	#category : #'PetitParserTooling-Core'
}

{ #category : #'as yet unclassified' }
PPTRuleStructureBuilderVisitor class >> obtainStructureFromRule: ast parser: parser withStrategy: strategy [
	| productionNode |
	productionNode := ((self newWithStrategy: strategy onRule: ast)
		visitGrammarRule: parser)
		obtainCodeRepresentation:
			(PPTCodeProduction
				productionName: strategy productionAccess
				keepPositions: strategy keepPositions).
	^ PPTCodeRule new
		ruleName: ast selector;
		nodeName: (strategy astNodeClassNameForRule: ast selector);
		productionNode: productionNode;
		keepPositions: strategy keepPositions;
		yourself
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitAction: aPP2ActionNode [
	^ (self isASeparatedBy: aPP2ActionNode)
		ifTrue: [ PPTRuleSeparatedBy new
				rule: (aPP2ActionNode child children first accept: self);
				separator:
					(aPP2ActionNode child children second children first children first
						accept: self);
				yourself ]
		ifFalse: [ aPP2ActionNode child accept: self ]
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitChoice: aPP2ChoiceNode [
	| key |
	key := aPP2ChoiceNode children
		collect: [ :aChild | aChild accept: self ]
		thenReject: #isNotInteresting.
	key
		ifEmpty: [ ^ PPTRuleToIgnore new ]
		ifNotEmpty: [ key size = aPP2ChoiceNode children size
				ifFalse: [ PPTIncorrectChoice signal ]
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
		shouldBeIgnored: [ PPTRuleToIgnore new ]
		else: [ (self shouldBeLocalyIgnored: aPP2DelegateNode name)
				ifTrue: [ PPTRuleToIgnore new ]
				ifFalse: [ PPTRuleLeaf
						name:
							(self ruleRenaming
								at: aPP2DelegateNode name
								ifPresent: [ :renamingStack | renamingStack pop ]
								ifAbsent: [ aPP2DelegateNode name ]) ] ]
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitFlatten: aPP2FlattenNode [ 
	^ aPP2FlattenNode child accept: self
]

{ #category : #'entry-point' }
PPTRuleStructureBuilderVisitor >> visitGrammarRule: aGrammarRule [
	self globalReification
		ifNotNil: [ ^ PPTRuleLeaf name: self globalReification ].
	^ [ ([ aGrammarRule child accept: self ]
		on: PPTChoiceReificationNotDefined
		do: [ :exception | 
			exception contextNode = aGrammarRule child
				ifTrue:
					[ "In this case, the choice that is not reify is the direct child of the rule, so we will use directly the choice as a leaf" PPTRuleLeaf name: aGrammarRule name ]
				ifFalse: [ exception
						rule: aGrammarRule name;
						signal ] ]) ensureInteresting ]
		on: PPTIncorrectChoice , PPTEmptyASTNode
		do: [ :exception | 
			exception rule: aGrammarRule.
			exception signal ]
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitLiteralObject: aPP2LiteralObjectNode [ 
	^ PPTRuleToIgnore new
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitLiteralSequence: aPP2LiteralSequenceNode [ 
	^ PPTRuleToken literal: aPP2LiteralSequenceNode literal
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitNot: aPP2NotNode [ 
	^ PPTRuleToIgnore new
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitOptional: aPP2OptionalNode [
	^ (aPP2OptionalNode child accept: self)
		in: [ :result | 
			result isNotInteresting
				ifFalse: [ PPTRuleOptional new
						rule: result;
						yourself ]
				ifTrue: [ (result isToken
						and: [ self shouldAcknowledgePresenceOf: result token ])
						ifTrue: [ PPTRuleOptional new
								rule: result;
								yourself ]
						ifFalse: [ PPTRuleToIgnore new ] ] ]
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitPossesiveRepeating: aPP2PossesiveRepeatingNode [
	^ (aPP2PossesiveRepeatingNode child accept: self)
		in: [ :childRule | 
			childRule isInteresting
				ifTrue: [ childRule class = PPTRulesWithPosition
						ifTrue: [ childRule intoCollectsWithPositions ]
						ifFalse: [ PPTRuleRepeating new
								rule: childRule;
								yourself ] ]
				ifFalse: [ PPTRuleToIgnore new ] ]
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitPredicateObject: aPP2PredicateObjectNode [ 
	^ PPTRuleToIgnore new
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitPredicateSequence: aPP2PredicateSequenceNode [ 
	^ PPTRuleToIgnore new
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitSequence: aPP2SequenceNode [
	^ PPTRulesWithPosition
		createFrom:
			((aPP2SequenceNode children
				collectWithIndex: [ :aChild :index | 
					(aChild accept: self)
						in: [ :childRule | 
							childRule isNotInteresting
								ifFalse: [ PPTRuleNodePosition new
										position: index;
										node: childRule;
										yourself ]
								ifTrue: [ PPTRuleToIgnore new ] ] ]) reject: #isNotInteresting)
]

{ #category : #visit }
PPTRuleStructureBuilderVisitor >> visitTrimming: aPP2TrimmingNode [ 
	^ aPP2TrimmingNode child accept: self
]
