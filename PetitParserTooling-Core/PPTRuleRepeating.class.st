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

{ #category : #generation }
PPTRuleRepeating >> methodCodeWith: aString [ 
	^ self rule methodCodePluralizeWith: aString
]

{ #category : #accessing }
PPTRuleRepeating >> rule [
	^ rule
]

{ #category : #accessing }
PPTRuleRepeating >> rule: anObject [
	rule := anObject
]
