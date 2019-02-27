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

{ #category : #try }
PPTRulesWithPosition >> intoCollect [
	^ self rulesWithPosition collect: #intoCollect
]

{ #category : #try }
PPTRulesWithPosition >> intoCollectWithPosition [
	self shouldBeImplemented.
]

{ #category : #try }
PPTRulesWithPosition >> intoCollectsWithPositions [
	^ PPTRuleCollectsWithPositions rules: (self rulesWithPosition collect: #intoCollectWithPosition)
]

{ #category : #'as yet unclassified' }
PPTRulesWithPosition >> methodCodePluralizeWith: aString [ 
	^ String
		streamContents: [ :s | 
			s
				nextPutAll:
					((self rulesWithPosition
						collect: [ :aRule | aRule methodCodePluralizeWith: aString ])
						joinUsing: '; ').
			self rulesWithPosition size > 1
				ifTrue: [ s nextPutAll: '; yourself' ] ]
]

{ #category : #creation }
PPTRulesWithPosition >> methodCodeWith: aString [
	^ String
		streamContents: [ :s | 
			s
				nextPutAll:
					((self rulesWithPosition
						collect: [ :aRule | aRule methodCodeWith: aString ])
						joinUsing: '; ').
			self rulesWithPosition size > 1
				ifTrue: [ s nextPutAll: '; yourself' ] ]
]

{ #category : #serialization }
PPTRulesWithPosition >> obtainCodeRepresentation: aPPTCode [
	^ PPTCodeCascade
		codes:
			(self rulesWithPosition
				collect:
					[ :aRuleWithPosition | aRuleWithPosition obtainCodeRepresentation: aPPTCode ])
]

{ #category : #accessing }
PPTRulesWithPosition >> rulesWithPosition [
	^ rulesWithPosition
]

{ #category : #accessing }
PPTRulesWithPosition >> rulesWithPosition: anObject [
	rulesWithPosition := anObject
]
