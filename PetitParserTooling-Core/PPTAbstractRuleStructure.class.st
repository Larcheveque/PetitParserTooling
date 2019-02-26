Class {
	#name : #PPTAbstractRuleStructure,
	#superclass : #Object,
	#category : #'PetitParserTooling-Core'
}

{ #category : #testing }
PPTAbstractRuleStructure >> isLeaf [
	^ false
]

{ #category : #testing }
PPTAbstractRuleStructure >> methodCodeForProductionName: aProductionName [
	^ String
		streamContents:
			[ :stream | (self obtainCodeRepresentation: (PPTCodeProduction productionName: aProductionName)) serializeOn: stream ]
]

{ #category : #representation }
PPTAbstractRuleStructure >> obtainCodeRepresentation [
	^ self subclassResponsibility 
]

{ #category : #serialization }
PPTAbstractRuleStructure >> obtainCodeRepresentation: aPPTCode [
	^ self subclassResponsibility 
]
