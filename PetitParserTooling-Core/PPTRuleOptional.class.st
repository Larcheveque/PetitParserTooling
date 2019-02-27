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

{ #category : #serialization }
PPTRuleOptional >> obtainCodeRepresentation: aPPTCode [
	^ (self rule obtainCodeRepresentation: aPPTCode) optional
]

{ #category : #accessing }
PPTRuleOptional >> rule [
	^ rule
]

{ #category : #accessing }
PPTRuleOptional >> rule: anObject [
	rule := anObject
]
