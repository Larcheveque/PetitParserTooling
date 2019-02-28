Class {
	#name : #PPTRuleRepeating,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'rule'
	],
	#category : #'PetitParserTooling-Core'
}

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
