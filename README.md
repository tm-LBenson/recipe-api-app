# Recipe Management API

This is a RESTful API built using Django for managing recipes. The API allows users to create, read, update, and delete recipes, as well as manage ingredients and other related data.

## Features

- Manage recipes
- Manage ingredients
- Filter recipes by ingredients
- Authentication and authorization support
- Pagination for listing recipes

## Requirements

- Docker
- Docker Compose

## Endpoints

### Authentication

- Register a new user: POST /api/users/register/
- Login: POST /api/users/login/
- Logout: POST /api/users/logout/

### Recipes

- List all recipes: GET /api/recipes/
- Retrieve a specific recipe: GET /api/recipes/<id>/
- Create a new recipe: POST /api/recipes/
- Update a recipe: PUT /api/recipes/<id>/
- Delete a recipe: DELETE /api/recipes/<id>/

### Ingredients

- List all ingredients: GET /api/ingredients/
- Retrieve a specific ingredient: GET /api/ingredients/<id>/
- Create a new ingredient: POST /api/ingredients/
- Update an ingredient: PUT /api/ingredients/<id>/
- Delete an ingredient: DELETE /api/ingredients/<id>/

## Testing

To run tests for the Recipe Management API, execute the following command:

```bash
docker-compose run app sh -c "python manage.py test"
```

docker-compose run app sh -c "python manage.py test"

This command will run the test suite inside the Docker container.

## License

This project is licensed under the MIT License. See the LICENSE file for more information.
