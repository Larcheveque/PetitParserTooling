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
	^ self node obtainCodeRepresentation: aPPTCode "(PPTCodeCollect receiver: aPPTCodePosition)."
]

{ #category : #accessing }
PPTRuleCollectWithPosition >> position [
	^ position
]

{ #category : #accessing }
PPTRuleCollectWithPosition >> position: anObject [
	position := anObject
]
