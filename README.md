# LiveWeather

LiveWeather is an iOS application that allows users to search for any city in the world and view current weather conditions and forecasts using public APIs.

---

## Architecture

The app follows the principles of **Clean Architecture**:

Presentation (MVP)  
├── UI (ViewController + Views)  
└── Presenter

Domain  
├── Entities  
├── Use Cases  
└── Repository Interfaces

Data  
├── DTOs  
├── API Services  
├── Mappers  
└── Repositories

- **MVP (Model-View-Presenter)**: Decouples UI from business logic.  
- **SOLID principles**: Ensure scalability and testability.  
- **Protocol-oriented dependencies**: Enable testability and mocking.  
- **Coordinators**: Centralized navigation using `AppCoordinator`.

---

## APIs Used

### GeoNames (https://www.geonames.org/export/geonames-search.html)
- **Endpoint**: `https://secure.geonames.org/searchJSON`
- City search by name (`name_startsWith`)

### wttr.in (https://wttr.in/:help)
- **Endpoint**: `https://wttr.in/{lat},{lng}?format=j1`
- Weather info by coordinates


---

## Features

1. Search cities by name (with pagination).  
2. View results with name, country and coordinates.  
3. Tap a city to view:
   - Current weather (temperature, description, humidity, wind)
   - 3-day forecast  

---

## Installation

1. Clone the repository:

git clone https://github.com/joanmarcs/liveweather.git
cd liveweather

2. Open the project in Xcode

3. Run the project on the simulator or a device

---

## Usage

- Launch the app
- Use the search bar to type a city
- Tap a result to view weather
- View current data + 3-day forecast
