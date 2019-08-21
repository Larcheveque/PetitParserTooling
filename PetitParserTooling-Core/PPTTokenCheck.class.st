Class {
	#name : #PPTTokenCheck,
	#superclass : #PPTCode,
	#instVars : [
		'token',
		'checkedNode'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #accessing }
PPTTokenCheck >> allAssignations [
	^ { self }
]

{ #category : #accessing }
PPTTokenCheck >> checkedNode [
	^ checkedNode
]

{ #category : #accessing }
PPTTokenCheck >> checkedNode: anObject [
	checkedNode := anObject
]

{ #category : #naming }
PPTTokenCheck >> finalName [
	^ self token
]

{ #category : #pcg }
PPTTokenCheck >> obtainPCGNode [
	^ PCGMessageNode new
		selector: self token asSymbol asMutator;
		arguments: {(self checkedNode obtainPCGNode receiveMessage: #notNil)};
		yourself
]

{ #category : #serialization }
PPTTokenCheck >> optional [
	"because i am implemented to check the presence or not of a token, i am always optional"
	^ self
]

{ #category : #serialization }
PPTTokenCheck >> pluralized [
	PPTInvalidAcknowledgeUsage signalForToken: self token
]

{ #category : #accessing }
PPTTokenCheck >> token [
	^ token
]

{ #category : #accessing }
PPTTokenCheck >> token: anObject [
	token := anObject
]
