Class {
	#name : #PPTRuleNodePosition,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'node',
		'position'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #generation }
PPTRuleNodePosition >> methodCode [
	^ (node methodCodeWith: '(production') , ' at: '
		, self position asString , ')'
]

{ #category : #accessing }
PPTRuleNodePosition >> node [
	^ node
]

{ #category : #accessing }
PPTRuleNodePosition >> node: anObject [
	node := anObject
]

{ #category : #accessing }
PPTRuleNodePosition >> position [
	^ position
]

{ #category : #accessing }
PPTRuleNodePosition >> position: anObject [
	position := anObject
]
