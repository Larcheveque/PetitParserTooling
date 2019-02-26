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

{ #category : #optional }
PPTCodeCascade >> optional [
	self codes: ( self codes collect: #optional).
	^ self
]

{ #category : #serialization }
PPTCodeCascade >> serializeOn: aStream [
	self codes
		do: [ :aPPTCode | aPPTCode serializeOn: aStream ]
		separatedBy: [ aStream nextPutAll: '; ' ]
]
