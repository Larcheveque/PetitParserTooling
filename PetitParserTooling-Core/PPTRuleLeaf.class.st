Class {
	#name : #PPTRuleLeaf,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'ruleName'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTRuleLeaf class >> name: aString [
	^ self new
		ruleName: aString;
		yourself
]

{ #category : #properties }
PPTRuleLeaf >> attributesToCreate [
	^ {self ruleName}
]

{ #category : #testing }
PPTRuleLeaf >> isLeaf [
	^ true
]

{ #category : #accessing }
PPTRuleLeaf >> methodCode [
	^ self ruleName, ': production; yourself'
]

{ #category : #generation }
PPTRuleLeaf >> methodCodePluralizeWith: productionIdentifier [ 
	^ self ruleName , 's: ' , productionIdentifier
]

{ #category : #generation }
PPTRuleLeaf >> methodCodeWith: productionIdentifier [
	^ self ruleName , ': ' , productionIdentifier
]

{ #category : #serialization }
PPTRuleLeaf >> obtainCodeRepresentation: aPPTCode [
	^ PPTCodeAttributeAssignation new
		assignedNode: aPPTCode;
		name: self ruleName;
		yourself
]

{ #category : #properties }
PPTRuleLeaf >> printOn: aStream [
	super printOn: aStream.
	aStream space.
	aStream nextPutAll: self ruleName
]

{ #category : #accessing }
PPTRuleLeaf >> ruleName [
	^ ruleName
]

{ #category : #accessing }
PPTRuleLeaf >> ruleName: anObject [
	ruleName := anObject
]
