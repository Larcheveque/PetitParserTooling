"
I am a class to store the result of a parsing and also the positions
"
Class {
	#name : #PPTInfoResult,
	#superclass : #Object,
	#instVars : [
		'start',
		'stop',
		'content'
	],
	#category : #'PetitParserTooling-PP2'
}

{ #category : #accessing }
PPTInfoResult >> content [
	^ content
]

{ #category : #accessing }
PPTInfoResult >> content: anObject [
	content := anObject
]

{ #category : #accessing }
PPTInfoResult >> start [
	^ start
]

{ #category : #accessing }
PPTInfoResult >> start: anObject [
	start := anObject
]

{ #category : #accessing }
PPTInfoResult >> stop [
	^ stop
]

{ #category : #accessing }
PPTInfoResult >> stop: anObject [
	stop := anObject
]
