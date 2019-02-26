Class {
	#name : #PPTCode,
	#superclass : #Object,
	#category : #'PetitParserTooling-Core'
}

{ #category : #serialization }
PPTCode >> pluralized [
	^ self subclassResponsibility 
]

{ #category : #serialization }
PPTCode >> serializeOn: aStream [
	self subclassResponsibility
]
