Class {
	#name : #PPTCodeCollect,
	#superclass : #PPTCode,
	#instVars : [
		'code',
		'subProductionCode',
		'receiver'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTCodeCollect class >> receiver: aReceiverPPTCode subProduction: aPPTCodeSubProduction code: aPPTCode [
	^ self new
		receiver: aReceiverPPTCode;
		code: aPPTCode;
		subProductionCode: aPPTCodeSubProduction;
		yourself
]

{ #category : #accessing }
PPTCodeCollect >> code [
	^ code
]

{ #category : #accessing }
PPTCodeCollect >> code: anObject [
	code := anObject
]

{ #category : #accessing }
PPTCodeCollect >> receiver [
	^ receiver
]

{ #category : #accessing }
PPTCodeCollect >> receiver: anObject [
	receiver := anObject
]

{ #category : #serialization }
PPTCodeCollect >> serializeOn: aStream [
	self receiver serializeOn: aStream.
	aStream nextPutAll: ' collect: [:'.
	self subProductionCode serializeOn: aStream.
	aStream nextPutAll: ' | '.
	self code serializeOn: aStream.
	aStream nextPutAll: ']'
]

{ #category : #accessing }
PPTCodeCollect >> subProductionCode [
	^ subProductionCode
]

{ #category : #accessing }
PPTCodeCollect >> subProductionCode: anObject [
	subProductionCode := anObject
]
