Class {
	#name : #PPTCodeProduction,
	#superclass : #PPTCode,
	#instVars : [
		'productionName',
		'keepPositions'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTCodeProduction class >> productionName: aString [
	^ self new
		productionName: aString;
		yourself
]

{ #category : #'instance creation' }
PPTCodeProduction class >> productionName: aString keepPositions: aBoolean [
	^ self new
		productionName: aString;
		keepPositions: aBoolean;
		yourself
]

{ #category : #experimental }
PPTCodeProduction >> collectReceiver [
	^ self
]

{ #category : #accessing }
PPTCodeProduction >> initialize [
	super initialize.
	self keepPositions: false
]

{ #category : #generation }
PPTCodeProduction >> isCodeProduction [
	^ true
]

{ #category : #accessing }
PPTCodeProduction >> keepPositions [
	^ keepPositions
]

{ #category : #accessing }
PPTCodeProduction >> keepPositions: anObject [
	keepPositions := anObject
]

{ #category : #pcg }
PPTCodeProduction >> obtainPCGNode [
	self keepPositions
		ifTrue: [ ^ PCGMessageNode
				receiver: self productionName asSymbol asPCGArgument
				selector: #content ]
		ifFalse: [ ^ self productionName asSymbol asPCGArgument ]
]

{ #category : #generation }
PPTCodeProduction >> obtainSubProduction [
	^ PPTCodeProduction
		productionName: 'sub' , self productionName capitalized
]

{ #category : #optional }
PPTCodeProduction >> optional [
	"here we are at the bottom of the tree so we don't care if it is optional or not"
	^ self
]

{ #category : #serialization }
PPTCodeProduction >> pluralized [
	^ self
]

{ #category : #accessing }
PPTCodeProduction >> productionName [
	^ productionName
]

{ #category : #accessing }
PPTCodeProduction >> productionName: anObject [
	productionName := anObject
]
