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

{ #category : #'attribute management' }
PPTCodeAttributeAssignation >> allAssignations [
	^ { self }
]

{ #category : #accessing }
PPTCodeAttributeAssignation >> assignedNode [
	^ assignedNode
]

{ #category : #accessing }
PPTCodeAttributeAssignation >> assignedNode: anObject [
	assignedNode := anObject
]

{ #category : #naming }
PPTCodeAttributeAssignation >> finalName [
	^ self name
		,
			(self isPluralized
				ifTrue: [ self name last = $s
						ifTrue: [ 'es' ]
						ifFalse: [ 's' ] ]
				ifFalse: [ '' ])
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

{ #category : #serialization }
PPTCodeAttributeAssignation >> obtainPCGNode [
	^ PCGMessageNode new
		selector: self finalName asMutator;
		arguments: {self assignedNode obtainPCGNode};
		yourself
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
	Halt now.
	aStream nextPutAll: self obtainPCGNode sourceCode
]

{ #category : #serialization }
PPTCodeAttributeAssignation >> serializeWithOpeningBracketOn: aStream [ 
	aStream nextPutAll: self name.
	self isPluralized
		ifTrue: [ aStream nextPut: $s ].
	aStream nextPutAll: ': ('.
	self assignedNode serializeOn: aStream
]
