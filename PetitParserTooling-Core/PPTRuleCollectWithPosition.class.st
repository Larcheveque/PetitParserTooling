Class {
	#name : #PPTRuleCollectWithPosition,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'position',
		'node'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #accessing }
PPTRuleCollectWithPosition >> node [
	^ node
]

{ #category : #accessing }
PPTRuleCollectWithPosition >> node: anObject [
	node := anObject
]

{ #category : #serialization }
PPTRuleCollectWithPosition >> obtainCodeRepresentation: aPPTCode [
	^ PPTCodeCollect new
		receiver: (self node obtainCodeRepresentation: aPPTCode) pluralized;
		position: self position;
		subProductionCode: aPPTCode obtainSubProduction
]

{ #category : #accessing }
PPTRuleCollectWithPosition >> position [
	^ position
]

{ #category : #accessing }
PPTRuleCollectWithPosition >> position: anObject [
	position := anObject
]
