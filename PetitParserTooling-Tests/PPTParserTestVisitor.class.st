Class {
	#name : #PPTParserTestVisitor,
	#superclass : #BISimpleFormatter,
	#category : #'PetitParserTooling-Tests'
}

{ #category : #visiting }
PPTParserTestVisitor >> visitVariableNode: aVariableNode [
	codeStream
		nextPutAll: '((PP2DelegateNode on: (#failure asPParser)) name: #';
		nextPutAll: aVariableNode name;
		nextPutAll: '; yourself)'
]
