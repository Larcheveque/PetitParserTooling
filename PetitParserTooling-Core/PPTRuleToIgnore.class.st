Class {
	#name : #PPTRuleToIgnore,
	#superclass : #PPTAbstractRuleStructure,
	#category : #'PetitParserTooling-Core'
}

{ #category : #testing }
PPTRuleToIgnore >> isNotInteresting [
	^ true
]

{ #category : #serialization }
PPTRuleToIgnore >> obtainCodeRepresentation: aPPTCode [
	^ self
		error:
			'We should never be there, this object is a null pattern that should be eliminated when we ask for the code representation'
]
