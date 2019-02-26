Class {
	#name : #PPTCodeAttributeAssignation,
	#superclass : #PPTCode,
	#instVars : [
		'name',
		'isPluralized',
		'assignedNode'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTCodeAttributeAssignation class >> named: aName [
	^ self new
		name: aName;
		yourself
]

{ #category : #accessing }
PPTCodeAttributeAssignation >> assignedNode [
	^ assignedNode
]

{ #category : #accessing }
PPTCodeAttributeAssignation >> assignedNode: anObject [
	assignedNode := anObject
]

{ #category : #initialization }
PPTCodeAttributeAssignation >> initialize [
	super initialize.
	self isPluralized: false
]

{ #category : #accessing }
PPTCodeAttributeAssignation >> isPluralized [
	^ isPluralized
]

{ #category : #accessing }
PPTCodeAttributeAssignation >> isPluralized: anObject [
	isPluralized := anObject
]

{ #category : #accessing }
PPTCodeAttributeAssignation >> name [
	^ name
]

{ #category : #accessing }
PPTCodeAttributeAssignation >> name: anObject [
	name := anObject
]

{ #category : #optional }
PPTCodeAttributeAssignation >> optional [
	self assignedNode: (self assignedNode optional).
	^ self
]

{ #category : #accessing }
PPTCodeAttributeAssignation >> pluralized [
	self isPluralized: true.
	^ self
]

{ #category : #reject }
PPTCodeAttributeAssignation >> rejectSeparator [
	self assignedNode: (PPTCodeRejectSeparator code: self assignedNode).
	^ self
]

{ #category : #serialization }
PPTCodeAttributeAssignation >> serializeOn: aStream [
	aStream nextPutAll: self name.
	self isPluralized
		ifTrue: [ aStream nextPut: $s ].
	aStream nextPutAll: ': '.
	self assignedNode serializeOn: aStream
]
