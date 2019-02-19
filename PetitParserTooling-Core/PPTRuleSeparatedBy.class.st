Class {
	#name : #PPTRuleSeparatedBy,
	#superclass : #PPTAbstractRuleStructure,
	#instVars : [
		'rule',
		'separator'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #creation }
PPTRuleSeparatedBy >> attributesToCreate [
	^ (self rule attributesToCreate
		collect: [ :attribute | attribute , 's' ])
		,
			(self separator
				ifNil: #()
				ifNotNil: [ self separator attributesToCreate
						collect: [ :attribute | attribute , 's' ] ])
]

{ #category : #creation }
PPTRuleSeparatedBy >> methodCodeWith: aProductionName [
	^ String
		streamContents: [ :s | 
			s
				nextPutAll:
					(self rule
						methodCodePluralizeWith: '(self rejectSeparators: ' , aProductionName).
			s nextPutAll: ')'.
			self separator
				ifNotNil: [ s nextPutAll: '; '.
					s
						nextPutAll:
							(self rule
								methodCodePluralizeWith: '(self selectSeparators: ' , aProductionName).
					s nextPutAll: ')' ] ]
]

{ #category : #accessing }
PPTRuleSeparatedBy >> rule [
	^ rule
]

{ #category : #accessing }
PPTRuleSeparatedBy >> rule: anObject [
	rule := anObject
]

{ #category : #accessing }
PPTRuleSeparatedBy >> separator [
	^ separator
]

{ #category : #accessing }
PPTRuleSeparatedBy >> separator: anObject [
	separator := anObject
]
