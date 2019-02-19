Class {
	#name : #PPTRuleNodePosition,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'node',
		'position'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #properties }
PPTRuleNodePosition >> attributesToCreate [
	^ self node attributesToCreate 
]

{ #category : #generation }
PPTRuleNodePosition >> methodCodeWith: aProductionName [
	^ (node methodCodeWith: '(' , aProductionName) , ' at: '
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
