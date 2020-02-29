from django.db import models
from django.db.models import TextChoices
from django.db.models.signals import pre_save


"""
Пример модели уведомлений для изменения статусов разных моделей.
"""

class NtType(TextChoices):
    COUNTRY = 'COUNTRY', 'COUNTRY'
    CITY = 'CITY', 'CITY'
    SIMPLE = 'SIMPLE', 'SIMPLE'


class Nt(models.Model):
    user = models.ForeignKey('common.User', models.CASCADE)
    message = models.TextField('сообщение')
    type = models.TextField('тип', choices=NtType.choices)

    def build_message(self):
        pass

    def entity(self) -> models.Model:
        if hasattr(self, 'nt_city'):
            return self.nt_city.entity()
        elif hasattr(self, 'nt_country'):
            return self.nt_country.entity()


class NtCountry(Nt):
    def __init__(self, *args, **kwargs):
        self._meta.get_field('type').default = NtType.COUNTRY
        super().__init__(*args, **kwargs)

    country = models.ForeignKey('common.Country', models.CASCADE)

    def build_message(self):
        return f"Страна {self.country}, {self.user}"

    def entity(self):
        return self.country


class NtCity(Nt):
    def __init__(self, *args, **kwargs):
        self._meta.get_field('type').default = NtType.CITY
        super().__init__(*args, **kwargs)

    city = models.ForeignKey('common.City', models.CASCADE)

    def build_message(self):
        return f"Город {self.city} {self.city.region.country}"

    def entity(self):
        return self.city


class NtSimple(Nt):
    def __init__(self, *args, **kwargs):
        self._meta.get_field('type').default = NtType.SIMPLE
        super().__init__(*args, **kwargs)

    def build_message(self):
        return f"NtSimple, {self.user}"


def nt_pre_save(sender, **kwargs):
    instance: Nt = kwargs.get('instance')
    if instance.pk is None and instance.message is None:
        instance.message = instance.build_message()


pre_save.connect(nt_pre_save, sender=Nt)
