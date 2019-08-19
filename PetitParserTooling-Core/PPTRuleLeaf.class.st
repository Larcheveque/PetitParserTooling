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

{ #category : #testing }
PPTRuleLeaf >> isLeaf [
	^ true
]

{ #category : #serialization }
PPTRuleLeaf >> obtainCodeRepresentation: aPPTCode [
	^ PPTCodeAttributeAssignation new
		assignedNode: aPPTCode;
		name: self ruleName;
		yourself
]

{ #category : #pcg }
PPTRuleLeaf >> obtainPCGNode [ 
	self shouldBeImplemented.
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
