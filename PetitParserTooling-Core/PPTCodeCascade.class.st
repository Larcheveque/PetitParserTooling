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

{ #category : #'attribute management' }
PPTCodeCascade >> allAssignations [
	^ self codes flatCollect: #allAssignations
]

{ #category : #accessing }
PPTCodeCascade >> codes [
	^ codes
]

{ #category : #accessing }
PPTCodeCascade >> codes: anObject [
	codes := anObject
]

{ #category : #helper }
PPTCodeCascade >> obtainCascadePCGNode [
	^ self obtainPCGNode 
]

{ #category : #pcg }
PPTCodeCascade >> obtainPCGNode [
	| cascade |
	cascade := PCGCascadeNode new.
	self codes
		do: [ :aCode | 
			| pcgNode |
			pcgNode := aCode obtainPCGNode.
			pcgNode class = PCGCascadeNode
				ifTrue: [ cascade messages addAll: pcgNode messages ]
				ifFalse: [ cascade addMessage: pcgNode ] ].
	^ cascade
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
