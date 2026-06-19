<template>
    <div class="db-card mb-6">
        <div class="db-card-body">
            <div class="flex flex-wrap gap-3">
                <router-link :to="{ name: 'admin.settings.appSettings.todaysSpecial' }" class="db-btn py-2" :class="tabClass('todays-special')">
                    Today's Special
                </router-link>
                <router-link :to="{ name: 'admin.settings.appSettings.appIntroVideo' }" class="db-btn py-2" :class="tabClass('app-intro-video')">
                    App Intro Video
                </router-link>
                <router-link :to="{ name: 'admin.settings.appSettings.updates' }" class="db-btn py-2" :class="tabClass('updates')">
                    Updates
                </router-link>
                <router-link :to="{ name: 'admin.settings.appSettings.appColor' }" class="db-btn py-2" :class="tabClass('app-color')">
                    App Color
                </router-link>
                <router-link :to="{ name: 'admin.settings.appSettings.banners' }" class="db-btn py-2" :class="tabClass('banners')">
                    Banners
                </router-link>
            </div>
        </div>
    </div>

    <router-view></router-view>
</template>

<script>
export default {
    name: "AppSettingsComponent",
    methods: {
        tabClass(path) {
            return this.$route.path.includes(path)
                ? "text-white bg-primary"
                : "text-primary bg-[#F8ECF4]";
        },
    },
};
</script>
