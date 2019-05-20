"
I am the parser to create an InfoResult, an object containing the result of the parsing and its position in the stream. I use a PPTCreateInfoStrategy to do that
"
Class {
	#name : #PPTCreateInfoNode,
	#superclass : #PP2DelegateNode,
	#category : #'PetitParserTooling-PP2'
}

{ #category : #visiting }
PPTCreateInfoNode >> accept: aPP2ParserVisitor [
	^ aPP2ParserVisitor visitCreateInfo: self
]

{ #category : #initialization }
PPTCreateInfoNode >> resetStrategy [
	strategy := PPTCreateInfoStrategy on: self
]
