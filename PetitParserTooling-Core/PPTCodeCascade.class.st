Class {
	#name : #PPTCodeCascade,
	#superclass : #PPTCode,
	#instVars : [
		'codes'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTCodeCascade class >> codes: aCollectionOfPPTCodes [
	^ self new
		codes: aCollectionOfPPTCodes;
		yourself
]

{ #category : #accessing }
PPTCodeCascade >> codes [
	^ codes
]

{ #category : #accessing }
PPTCodeCascade >> codes: anObject [
	codes := anObject
]

{ #category : #serialization }
PPTCodeCascade >> intoCollect [
	self codes: (self codes collect: #intoCollect).
	^ self
]

{ #category : #optional }
PPTCodeCascade >> optional [
	self codes: ( self codes collect: #optional).
	^ self
]

{ #category : #serialization }
PPTCodeCascade >> pluralized [
	self codes: (self codes collect: #pluralized).
	^ self 
]

{ #category : #serialization }
PPTCodeCascade >> serializeOn: aStream [
	self codes
		do: [ :aPPTCode | aPPTCode serializeOn: aStream ]
		separatedBy: [ aStream nextPutAll: '; ' ]
]

{ #category : #generation }
PPTCodeCascade >> subProduction [
	self codes: (self codes collect: #subProduction)
]
