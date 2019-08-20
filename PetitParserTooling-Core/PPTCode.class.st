"
I am an abstract class that represent the parser code that will be then generated.
"
Class {
	#name : #PPTCode,
	#superclass : #Object,
	#category : #'PetitParserTooling-Core'
}

{ #category : #source }
PPTCode >> generatedSourceCode [
	^ self obtainPCGNode sourceCode
]

{ #category : #testing }
PPTCode >> isCodeProduction [
	^ false
]

{ #category : #helper }
PPTCode >> obtainCascadePCGNode [
	^ PCGCascadeNode new
		addMessage: self obtainPCGNode;
		yourself
]

{ #category : #pcg }
PPTCode >> obtainPCGNode [
	^ self subclassResponsibility
]

{ #category : #generation }
PPTCode >> obtainSubProduction [
	^ self subclassResponsibility 
]

{ #category : #serialization }
PPTCode >> optional [
	^ self subclassResponsibility 
]

{ #category : #serialization }
PPTCode >> pluralized [
	^ self subclassResponsibility 
]
