# Generated by Django 4.2 on 2023-04-10 17:29
from typing import List

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies: List[tuple[str, str]] = []

    operations = [
        migrations.CreateModel(
            name="User",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("dni", models.CharField(max_length=13, unique=True)),
                ("name", models.CharField(max_length=30)),
            ],
        ),
    ]
