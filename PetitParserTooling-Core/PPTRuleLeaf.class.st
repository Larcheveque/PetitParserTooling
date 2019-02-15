Class {
	#name : #PPTRuleLeaf,
	#superclass : #Object,
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

{ #category : #accessing }
PPTRuleLeaf >> methodCode [
	^ self ruleName, ': production'
]

{ #category : #accessing }
PPTRuleLeaf >> ruleName [
	^ ruleName
]

{ #category : #accessing }
PPTRuleLeaf >> ruleName: anObject [
	ruleName := anObject
]
