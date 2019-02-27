Class {
	#name : #PPTRuleRepeating,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'rule'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #properties }
PPTRuleRepeating >> attributesToCreate [
	^ self rule attributesToCreate
		collect: [ :attribute | attribute , 's' ]
]

{ #category : #serialization }
PPTRuleRepeating >> obtainCodeRepresentation: aPPTCodeProduction [
	^ (self rule obtainCodeRepresentation: aPPTCodeProduction) pluralized
]

{ #category : #accessing }
PPTRuleRepeating >> rule [
	^ rule
]

{ #category : #accessing }
PPTRuleRepeating >> rule: anObject [
	rule := anObject
]
