Class {
	#name : #PPTRulesWithPosition,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'rulesWithPosition'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTRulesWithPosition class >> createFrom: anArray [
	^ anArray
		ifEmpty: [ PPTRuleToIgnore new ]
		ifNotEmpty: [ self new
				rulesWithPosition: anArray;
				yourself ]
]

{ #category : #try }
PPTRulesWithPosition >> intoCollectsWithPositions [
	^ PPTRuleCollectsWithPositions rules: (self rulesWithPosition collect: #intoCollectWithPosition)
]

{ #category : #serialization }
PPTRulesWithPosition >> obtainCodeRepresentation: aPPTCode [
	^ PPTCodeCascade
		codes:
			(self rulesWithPosition
				collect:
					[ :aRuleWithPosition | aRuleWithPosition obtainCodeRepresentation: aPPTCode ])
]

{ #category : #'not sure' }
PPTRulesWithPosition >> ruleName [
	self assert: self rulesWithPosition size = 1  description: 'It is only possible to have one named rule in a sequence'.
	^ self rulesWithPosition anyOne ruleName
]

{ #category : #accessing }
PPTRulesWithPosition >> rulesWithPosition [
	^ rulesWithPosition
]

{ #category : #accessing }
PPTRulesWithPosition >> rulesWithPosition: anObject [
	rulesWithPosition := anObject
]
