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

{ #category : #try }
PPTRuleNodePosition >> intoCollect [
	self shouldBeImplemented.
]

{ #category : #try }
PPTRuleNodePosition >> intoCollectWithPosition [
	^ PPTRuleCollectWithPosition new
		position: self position;
		node: self node;
		yourself
]

{ #category : #'as yet unclassified' }
PPTRuleNodePosition >> methodCodePluralizeWith: aProductionName [ 
	^ node
		methodCodePluralizeWith: '(' , aProductionName , ' at: ' , self position asString , ')'
]

{ #category : #generation }
PPTRuleNodePosition >> methodCodeWith: aProductionName [
	^ node
		methodCodeWith: '(' , aProductionName , ' at: ' , self position asString , ')'
]

{ #category : #accessing }
PPTRuleNodePosition >> node [
	^ node
]

{ #category : #accessing }
PPTRuleNodePosition >> node: anObject [
	node := anObject
]

{ #category : #serialization }
PPTRuleNodePosition >> obtainCodeRepresentation: aPPTCode [
	^ self node
		obtainCodeRepresentation:
			(PPTCodePosition new
				code: aPPTCode;
				position: self position;
				yourself)
]

{ #category : #accessing }
PPTRuleNodePosition >> position [
	^ position
]

{ #category : #accessing }
PPTRuleNodePosition >> position: anObject [
	position := anObject
]
