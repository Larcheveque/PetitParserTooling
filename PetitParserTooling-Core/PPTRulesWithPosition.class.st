Class {
	#name : #PPTRulesWithPosition,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'rulesWithPosition'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #'instance creation' }
PPTRulesWithPosition class >> createFrom: anArray [
	^ anArray
		ifEmpty: [ nil ]
		ifNotEmpty: [ self new
				rulesWithPosition: anArray;
				yourself ]
]

{ #category : #properties }
PPTRulesWithPosition >> attributesToCreate [
	^ self rulesWithPosition flatCollect: #attributesToCreate
]

{ #category : #creation }
PPTRulesWithPosition >> methodCodeWith: aString [
	^ ((self rulesWithPosition
		collect: [ :aRule | aRule methodCodeWith: aString ]) joinUsing: '; ')
		, '; yourself'
]

{ #category : #accessing }
PPTRulesWithPosition >> rulesWithPosition [
	^ rulesWithPosition
]

{ #category : #accessing }
PPTRulesWithPosition >> rulesWithPosition: anObject [
	rulesWithPosition := anObject
]
