Class {
	#name : #PPTEmptyASTNode,
	#superclass : #Error,
	#instVars : [
		'rule'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #accessing }
PPTEmptyASTNode >> messageText [
	^ '#' , self rule name
		,
			' - Nothing to store in the AST, maybe you should add this rule to the list of rules to flatten'
]

{ #category : #accessing }
PPTEmptyASTNode >> rule [
	^ rule
]

{ #category : #accessing }
PPTEmptyASTNode >> rule: anObject [
	rule := anObject
]
