Class {
	#name : #PPTCodePosition,
	#superclass : #PPTCode,
	#instVars : [
		'code',
		'position'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #accessing }
PPTCodePosition >> code [
	^ code
]

{ #category : #accessing }
PPTCodePosition >> code: anObject [
	code := anObject
]

{ #category : #serialization }
PPTCodePosition >> intoCollect [
	self code: self code intoCollect.
	^ self
]

{ #category : #generation }
PPTCodePosition >> obtainSubProduction [
	^ self code obtainSubProduction 
]

{ #category : #optional }
PPTCodePosition >> optional [
	^ PPTIfNotNilCode new
		testCode: self code;
		codeInBlock: self;
		yourself
]

{ #category : #serialization }
PPTCodePosition >> pluralized [
	self code: self code pluralized.
	^ self
]

{ #category : #accessing }
PPTCodePosition >> position [
	^ position
]

{ #category : #accessing }
PPTCodePosition >> position: anObject [
	position := anObject
]

{ #category : #serialization }
PPTCodePosition >> serializeOn: aStream [
	aStream nextPutAll: '('.
	self code serializeOn: aStream.
	aStream
		nextPutAll: ' at: ';
		nextPutAll: self position asString;
		nextPutAll: ')'
]

{ #category : #generation }
PPTCodePosition >> subProduction [
	self code: (self code subProduction).
	^ self
]
