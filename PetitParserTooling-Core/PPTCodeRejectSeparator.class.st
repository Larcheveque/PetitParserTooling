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

{ #category : #pcg }
PPTCodeRejectSeparator >> obtainPCGNode [
	^ PCGMessageNode
		receiver: #self asPCGNode
		selector: #rejectSeparators:
		arguments: {self code obtainPCGNode}
]

{ #category : #serialization }
PPTCodeRejectSeparator >> optional [
	^ PPTIfNotNilCode new
		testCode: self code;
		codeInBlock: self;
		yourself
]
