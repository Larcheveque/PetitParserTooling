Class {
	#name : #PPTCodeCollect,
	#superclass : #PPTCode,
	#instVars : [
		'subProductionCode',
		'receiver',
		'position'
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

{ #category : #'attribute management' }
PPTCodeCollect >> allAssignations [
	^ self receiver allAssignations 
]

{ #category : #accessing }
PPTCodeCollect >> position [
	^ position
]

{ #category : #accessing }
PPTCodeCollect >> position: anObject [
	position := anObject
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
	self receiver serializeWithOpeningBracketOn: aStream.
	aStream nextPutAll: ' collect: [:'.
	self subProductionCode parameterSerializeOn: aStream.
	aStream nextPutAll: ' | '.
	self subProductionCode serializeOn: aStream.
	aStream
		nextPutAll: ' at: ';
		nextPutAll: self position asString;
		nextPutAll: '])'
]

{ #category : #accessing }
PPTCodeCollect >> subProductionCode [
	^ subProductionCode
]

{ #category : #accessing }
PPTCodeCollect >> subProductionCode: anObject [
	subProductionCode := anObject
]
