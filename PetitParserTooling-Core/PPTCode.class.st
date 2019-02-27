Class {
	#name : #PPTCode,
	#superclass : #Object,
	#category : #'PetitParserTooling-Core'
}

{ #category : #generation }
PPTCode >> child [
	^ self code
]

{ #category : #serialization }
PPTCode >> intoCollect [
	^ self subclassResponsibility 
]

{ #category : #testing }
PPTCode >> isCodeProduction [
	^ false
]

{ #category : #generation }
PPTCode >> obtainSubProduction [
	^ self subclassResponsibility 
]

{ #category : #serialization }
PPTCode >> optional [
	^ self subclassResponsibility 
]

{ #category : #serialization }
PPTCode >> pluralized [
	^ self subclassResponsibility 
]

{ #category : #generation }
PPTCode >> rejectSeparator [
	self codes: (self codes collect: #rejectSeparator).
	^ self
]

{ #category : #serialization }
PPTCode >> serializeOn: aStream [
	self subclassResponsibility
]

{ #category : #generation }
PPTCode >> subProduction [
	^ self subclassResponsibility 
]
