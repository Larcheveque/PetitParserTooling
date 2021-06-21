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

{ #category : #pcg }
PPTCodePosition >> obtainPCGNode [
	^ PCGMessageNode
		receiver: self code obtainPCGNode
		selector: #at:
		arguments: {self position asPCG}
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
