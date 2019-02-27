Class {
	#name : #PPTCodeRejectSeparator,
	#superclass : #PPTCode,
	#instVars : [
		'code'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTCodeRejectSeparator class >> code: aPPTCode [
	^ self new code: aPPTCode; yourself
]

{ #category : #accessing }
PPTCodeRejectSeparator >> code [
	^ code
]

{ #category : #accessing }
PPTCodeRejectSeparator >> code: anObject [
	code := anObject
]

{ #category : #serialization }
PPTCodeRejectSeparator >> optional [
	^ PPTIfNotEmptyCode new
		testCode: self code;
		codeInBlock: self;
		yourself
]

{ #category : #serialization }
PPTCodeRejectSeparator >> serializeOn: aStream [ 
	aStream nextPutAll: '(self rejectSeparators: '.
	self code serializeOn: aStream.
	aStream nextPutAll: ')'.
]
