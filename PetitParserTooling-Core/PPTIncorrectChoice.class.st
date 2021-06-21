"
I am an exception throwed when the grammar have a choice between interesting stuff and rejected ones (and so it's not possible to correctly create the AST)
"
Class {
	#name : #PPTIncorrectChoice,
	#superclass : #Error,
	#instVars : [
		'rule'
	],
	#category : #'PetitParserTooling-Core-Exceptions'
}

{ #category : #accessing }
PPTIncorrectChoice >> messageText [
	^ '#' , self rule name
		,
			' - The grammar should not have a choice between interesting stuff and rejected ones'
]

{ #category : #accessing }
PPTIncorrectChoice >> rule [
	^ rule
]

{ #category : #accessing }
PPTIncorrectChoice >> rule: anObject [
	rule := anObject
]
