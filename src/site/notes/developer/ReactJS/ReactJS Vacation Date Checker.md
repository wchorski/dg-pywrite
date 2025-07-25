---
{"dg-publish":true,"permalink":"/developer/react-js/react-js-vacation-date-checker/","dgPassFrontmatter":true}
---

I wanted to build a date picker with [[developer/ReactJS/ReactJS\|ReactJS]] that checks against an array of vacation days. The logic is vanilla [[developer/Javascript/Javascript\|Javascript]] and even uses the built in API `.toLocalDateString` for pretty formatting.

## AvailabilityChecker.tsx
```tsx
import { useRef, useState } from "react";
import { dateCheckAvailable } from "../../libs/dateCheck";

type FormVals = {
  date: string,
  durationInHours: string,
}

const vacationDays = [
  {
    dateTime: "2023-05-01T05:00:00Z",
    durationInHours: "24"
  },
  {
    dateTime: "2023-05-02T05:00:00Z",
    durationInHours: "12"
  },
  {
    dateTime: "2023-06-01T05:00:00Z",
    durationInHours: "24"
  },
  {
    dateTime: "2023-06-02T05:00:00Z",
    durationInHours: "24"
  },
  {
    dateTime: "2023-06-03T05:00:00Z",
    durationInHours: "24"
  },
];

export function AvailabilityChecker() {

  const inputRangeRef = useRef<HTMLInputElement>(null)
  const [hoursSliderVal, setHoursSliderVal] = useState('.25')
  const [message, setMessage] = useState("");
  const [formValues, setformValues] = useState<FormVals>({
    date: '',
    durationInHours: '',
  });

  function handleSubmit(e:any) {
    e.preventDefault();
    const { date, durationInHours} = formValues
    // console.table(formValues)
    if(!durationInHours.match(/^[0-9]+(\.[0-9]+)?$/)) return setMessage('Hours must only contain numbers "0-9" and one decimal "." ')
    
    dateCheckAvailable(date, durationInHours, vacationDays)
      ? setMessage('Date is Available')
      : setMessage('CONFLICT was found');
  }

  const handleChange = (event:any) => {
    setformValues({ ...formValues, [event.target.name]: event.target.value });
  }


  return (
    <div className="App">
      <h1> Does date picked overlap vacation date? </h1>

      <section>
        <h2>Vacation Days</h2>
        <ul className="vacation-days">
          {vacationDays.map((day) => (
            <li key={day.dateTime}>
              {prettyDate(day.dateTime)} <br />
              {day.durationInHours} hours 
            </li>
          ))}
        </ul>
      </section>

      <section>
        <form onSubmit={handleSubmit} className="date-picker">
          <label>
            Date Picked
            <input type="datetime-local" name="date" value={formValues.date} onChange={handleChange} required/>
          </label>
          <br />

          <label>
            Duration in Hours
            <input type="range" min={.25} max={24} step={.25} name="durationInHours" value={formValues.durationInHours} required ref={inputRangeRef} 
              onChange={(e) => {
                handleChange(e)
                setHoursSliderVal(String(e.target.value))
              }}
            />
            <span>{hoursSliderVal} hours </span>
          </label>
          <br />

          <button type="submit">check date</button>
        </form>
      </section>

      <p>Message: {message}</p>
    </div>
  );
}


function prettyDate(dateISO:string){

  const realDate = new Date(dateISO)

  return realDate.toLocaleDateString('en-US', 
    {
      month: 'long',
      day: 'numeric',
      year: 'numeric',
      hour: 'numeric',
      minute: 'numeric'
      // daySuffix: 'ordinal'
    }
  )
}
```

## dateCheck.ts
```ts
type VacayDay = {
  dateTime: string,
  durationInHours: string,
}

export function dateCheckAvailable(selectedDateTime:string, durationInHours:string, vacationDays:VacayDay[]) {

  const selectedStart = new Date(selectedDateTime)
  const durationMs = Number(durationInHours) * 60 * 60 * 1000
  const selectedEnd = new Date(selectedStart.getTime() + durationMs)

  for (let i = 0; i < vacationDays.length; i++) {

    const vacationStart = new Date(vacationDays[i].dateTime);
    const vacationEnd = new Date(vacationStart.getTime() + Number(vacationDays[i].durationInHours) * 60 * 60 * 1000)

    if (selectedEnd <= vacationStart || selectedStart >= vacationEnd) {
      console.log('the selected date time and the vacation day do not overlap')
      continue;
    } else {
      
      console.log('the selected date time and the vacation day overlap')
      return false;
    }
  }

  console.log('no vacation day overlaps with selected date')
  return true; // no vacation day overlaps with selected date
}

```
