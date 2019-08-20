Class {
	#name : #PPTRuleToken,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'token'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTRuleToken class >> literal: aLiteral [
	^ self new
		token: aLiteral;
		yourself
]

{ #category : #accessing }
PPTRuleToken >> isNotInteresting [
	^ true
]

{ #category : #accessing }
PPTRuleToken >> isToken [
	^ true
]

{ #category : #serialization }
PPTRuleToken >> obtainCodeRepresentation: aPPTCode [
	^ PPTTokenCheck new
		checkedNode: aPPTCode;
		token: self token;
		yourself
]

{ #category : #accessing }
PPTRuleToken >> token [
	^ token
]

{ #category : #accessing }
PPTRuleToken >> token: anObject [
	token := anObject
]
