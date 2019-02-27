Class {
	#name : #PPTIfNotNilCode,
	#superclass : #PPTCode,
	#instVars : [
		'testCode',
		'codeInBlock'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #accessing }
PPTIfNotNilCode >> codeInBlock [
	^ codeInBlock
]

{ #category : #accessing }
PPTIfNotNilCode >> codeInBlock: anObject [
	codeInBlock := anObject
]

{ #category : #serialization }
PPTIfNotNilCode >> serializeOn: aStream [ 
	aStream nextPut: $(.
	self testCode serializeOn: aStream.
	aStream nextPutAll: ' ifNotNil: ['.
	self codeInBlock serializeOn: aStream.
	aStream nextPutAll: '])'
]

{ #category : #accessing }
PPTIfNotNilCode >> testCode [
	^ testCode
]

{ #category : #accessing }
PPTIfNotNilCode >> testCode: anObject [
	testCode := anObject
]
