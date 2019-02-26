Class {
	#name : #PPTCodeProduction,
	#superclass : #PPTCode,
	#instVars : [
		'productionName'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTCodeProduction class >> productionName: aString [
	^ self new
		productionName: aString;
		yourself
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

{ #category : #serialization }
PPTCodeProduction >> serializeOn: aWriteStream [ 
	aWriteStream nextPutAll: self productionName 
]
