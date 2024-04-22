from fastapi import FastAPI, HTTPException
from app.utils.expert_system import PCDiagnosis
from server.app.schemas import Question, AnswerModel
app = FastAPI()


questions = [
    Question(question="Is the system overheating?", symptom="System_overheating"),
    Question(question="Is the system freezing intermittently?", symptom="Intermittent_freezing"),
    Question(question="Is the system performing slowly?", symptom="Slow_system_performance"),
    Question(question="Are you experiencing peripheral device failures?", symptom="Peripheral_device_failure"),
    Question(question="Is the USB device not recognized?", symptom="USB_device_not_recognized"),
    Question(question="Are you experiencing network connection issues?", symptom="Network_connection_issues"),
    Question(question="Are you seeing strange error messages?", symptom="Strange_error_messages"),
    Question(question="Are you seeing the blue screen of death?", symptom="Blue_screen_of_death"),
    Question(question="Are files or icons missing?", symptom="Missing_files_or_icons"),
    Question(question="Are you unable to access data?", symptom="Unable_to_access_data"),
    Question(question="Are you experiencing application errors?", symptom="Application_errors"),

]

@app.get("/questions")
async def get_questions():
    try : 
        return questions
    except:
        raise HTTPException(status_code=404, detail="Questions not found")



@app.post("/diagnose_issue")
async def diagnose_issue(answer: AnswerModel):
    try: 
        engine = PCDiagnosis()
        engine.initialFacts = [symptom.symptom for symptom in answer.symptoms]
        engine.reset()
        engine.diagnoses = []
        engine.run()
        print(engine.diagnoses) 
        if not engine.diagnoses:
            raise HTTPException(status_code=404, detail="No diagnosis found")
        
        return engine.diagnoses
    except:
        raise HTTPException(status_code=500, detail="Internal server error")
