Class {
	#name : #PPTIfNotEmptyCode,
	#superclass : #PPTCode,
	#instVars : [
		'testCode',
		'codeInBlock'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #accessing }
PPTIfNotEmptyCode >> codeInBlock [
	^ codeInBlock
]

{ #category : #accessing }
PPTIfNotEmptyCode >> codeInBlock: anObject [
	codeInBlock := anObject
]

{ #category : #serialization }
PPTIfNotEmptyCode >> serializeOn: aStream [ 
	aStream nextPut: $(.
	self testCode serializeOn: aStream.
	aStream nextPutAll: ' ifNotEmpty: ['.
	self codeInBlock serializeOn: aStream.
	aStream nextPutAll: '])'
]

{ #category : #accessing }
PPTIfNotEmptyCode >> testCode [
	^ testCode
]

{ #category : #accessing }
PPTIfNotEmptyCode >> testCode: anObject [
	testCode := anObject
]
