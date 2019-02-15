Class {
	#name : #PPTParserGeneratorVisitor,
	#superclass : #PPTGeneratorVisitor,
	#category : #'PetitParserTooling-Core'
}

{ #category : #visit }
PPTParserGeneratorVisitor >> visitPP2ChoiceNode: aPP2ChoiceNode [
	| key |
	key := aPP2ChoiceNode children
		collect: [ :aChild | aChild acceptVisitor: self ].
	^ PPTRuleLeaf
		name:
			(self ruleReifications
				at: (key collect: #ruleName)
				ifAbsent: [ PPTChoiceReificationNotDefined new
						rulesCombination: key;
						signal ])
]

{ #category : #visit }
PPTParserGeneratorVisitor >> visitPP2DelegateNode: aPP2DelegateNode [ 
	^ PPTRuleLeaf name: aPP2DelegateNode name
]

{ #category : #visit }
PPTParserGeneratorVisitor >> visitPPRule: aPP2DelegateNode [
	| ruleName parserClass |
	ruleName := aPP2DelegateNode name.
	parserClass := self class environment
		at: self generationStrategy parserClass.
	parserClass
		compile:
			ruleName
				,
					'
	<generated>
	^ super ' , ruleName , ' ==> [ :production | '
				, (self generationStrategy astNodeClassNameForRule: ruleName)
				, ' new '
				, (aPP2DelegateNode child acceptVisitor: self) methodCode
				, ' ; yourself ]'
]
