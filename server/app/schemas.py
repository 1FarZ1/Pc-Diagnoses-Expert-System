from typing import List

from pydantic import BaseModel


class Symptom(BaseModel):
    symptom: str


class AnswerModel(BaseModel):
     symptoms: List[Symptom]

     
class Question(BaseModel):
    question: str
    symptom : str
