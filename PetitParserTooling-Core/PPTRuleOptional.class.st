Class {
	#name : #PPTRuleOptional,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'rule'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #properties }
PPTRuleOptional >> attributesToCreate [
	^ self rule attributesToCreate
]

{ #category : #generation }
PPTRuleOptional >> methodCodePluralizeWith: productionIdentifier [
	self flag: #TODO. "Pluralize production identifier"
	^ self rule isLeaf
		ifTrue: [ self rule methodCodeWith: productionIdentifier  ]
		ifFalse: [ self rule
				methodCodeWith:
					'(' , productionIdentifier , ' ifNotNil: [ '
						, productionIdentifier  , ' ])' ]
]

{ #category : #generation }
PPTRuleOptional >> methodCodeWith: productionIdentifier [
	^ self rule isLeaf
		ifTrue: [ self rule methodCodeWith: productionIdentifier ]
		ifFalse: [ self rule
				methodCodeWith:
					'(' , productionIdentifier , ' ifNotNil: [ ' , productionIdentifier
						, ' ])' ]
]

{ #category : #accessing }
PPTRuleOptional >> rule [
	^ rule
]

{ #category : #accessing }
PPTRuleOptional >> rule: anObject [
	rule := anObject
]
