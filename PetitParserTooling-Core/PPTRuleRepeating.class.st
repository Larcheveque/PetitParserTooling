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

{ #category : #serialization }
PPTRuleRepeating >> obtainCodeRepresentation: aPPTCode [

	(self rule class = PPTRulesWithPosition) ifTrue: [ ^ PPTCodeCascade codes: self rule intoCollect ] .
	Halt now.
	(aPPTCode isCodeProduction or: [ aPPTCode child isCodeProduction ])
		ifTrue: [ ^ (self rule obtainCodeRepresentation: aPPTCode) pluralized ].
	^ self rule
		obtainCodeRepresentation:
			(PPTCodeCollect
				receiver: aPPTCode collectReceiver
				subProduction: aPPTCode obtainSubProduction
				code: aPPTCode subProduction)
]

{ #category : #accessing }
PPTRuleRepeating >> rule [
	^ rule
]

{ #category : #accessing }
PPTRuleRepeating >> rule: anObject [
	rule := anObject
]
