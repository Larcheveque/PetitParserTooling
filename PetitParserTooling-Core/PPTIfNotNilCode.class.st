Class {
	#name : #PPTIfNotNilCode,
	#superclass : #PPTCode,
	#instVars : [
		'testCode',
		'codeInBlock'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #accessing }
PPTIfNotNilCode >> codeInBlock [
	^ codeInBlock
]

{ #category : #accessing }
PPTIfNotNilCode >> codeInBlock: anObject [
	codeInBlock := anObject
]

{ #category : #pcg }
PPTIfNotNilCode >> obtainPCGNode [
	self testCode isCodeProduction
		ifTrue: [ ^ self codeInBlock obtainPCGNode ].
	^ PCGMessageNode
		receiver: self testCode obtainPCGNode
		selector: #ifNotNil:
		arguments: {self codeInBlock obtainPCGNode inBlock}
]

{ #category : #accessing }
PPTIfNotNilCode >> testCode [
	^ testCode
]

{ #category : #accessing }
PPTIfNotNilCode >> testCode: anObject [
	testCode := anObject
]
